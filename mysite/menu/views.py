import logging, json
from datetime import datetime, date, timedelta
from django.http import HttpResponse
from django.db.models import Q
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.utils.functional import curry
from django.core.exceptions import PermissionDenied
from django.core.urlresolvers import reverse, reverse_lazy
from django.views.generic import View, ListView, DetailView, CreateView, UpdateView, DeleteView
from django.views.generic.edit import FormView
from django.contrib.auth.decorators import login_required
from django.forms.models import modelformset_factory, modelform_factory
from menu.forms import MealRecipeForm, RecipeIngredientForm, GroceryForm

from menu.models import Meal, MealRecipe, Profile, Recipe, Ingredient, RecipeIngredient

from menu.converter import Converter


logger = logging.getLogger(__name__)

# Create your views here.
class ProfileView(DetailView):
    model = Profile
    context_object_name = 'profile'
    template_name = 'menu/profile.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(ProfileView, self).dispatch(*args, **kwargs)

    def get_object(self):

        try:
            profile = self.request.user.profile
        except Profile.DoesNotExist:
            profile = Profile.objects.create(user=self.request.user)

        return profile

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(ProfileView, self).get_context_data(**kwargs)
        # Add in a QuerySet of all the recipes
        context['recipes'] = self.request.user.profile.recipe_set.all()[:5]
        return context

class RecipeList(ListView):
    model = Recipe

    def get_queryset(self):
        return Recipe.objects.filter(
            Q(profile=self.request.user.profile)|Q(private=False)
        )


    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeList, self).dispatch(*args, **kwargs)

class RecipeDetailView(DetailView):
    model = Recipe
    template_name = 'menu/recipe_detail.html'

    def get_object(self):
        recipe = super(RecipeDetailView,self).get_object()
        if recipe.private and recipe.profile != self.request.user.profile:
            raise PermissionDenied

        return recipe

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeDetailView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(RecipeDetailView, self).get_context_data(**kwargs)
        # Add in a QuerySet of all the recipes
        context['rating_loop'] = [i for i in range(context['recipe'].rating)]
        context['recipe_ingredients'] = RecipeIngredient.objects.filter(recipe=context['recipe'])
        return context

class RecipeCreate(View):
    template_name = 'menu/recipe_form.html'
    success_url = reverse_lazy('menu:recipe_list')
    RecipeForm = modelform_factory(Recipe, fields=('name', 'private','rating','directions'))
    RecipeIngredientFormSet = modelformset_factory(RecipeIngredient, form=RecipeIngredientForm, fields=('amount','unit','ingredient'), extra=3)


    def get(self, request, *args, **kwargs):
        form = self.RecipeForm()
        formset = self.RecipeIngredientFormSet(queryset=RecipeIngredient.objects.none())
        return render(request, self.template_name, {
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        form = self.RecipeForm(request.POST)
        formset = self.RecipeIngredientFormSet(request.POST)
        if (form.is_valid() and formset.is_valid()):
            recipe = form.save(commit=False)
            recipe.profile = self.request.user.profile
            recipe.save()
            recipe_ingredients = formset.save(commit=False)
            for recipe_ingredient in recipe_ingredients:
                recipe_ingredient.recipe = recipe
                recipe_ingredient.save()

            return redirect(self.success_url)

        return render(request, self.template_name, {
            'form': form,
            'formset': formset
        })

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
       self.RecipeIngredientFormSet.form = staticmethod(curry(RecipeIngredientForm,profile=self.request.user.profile))
       return super(RecipeCreate, self).dispatch(*args, **kwargs)



class RecipeUpdate(View):
    template_name = 'menu/recipe_form.html'
    success_url = reverse_lazy('menu:recipe_list')
    RecipeForm = modelform_factory(Recipe, fields=('name', 'private','rating','directions'))
    RecipeIngredientFormSet = modelformset_factory(RecipeIngredient, form=RecipeIngredientForm, fields=('amount','unit','ingredient'), can_delete=True, extra=1)

    def get(self, request, *args, **kwargs):
        recipe = Recipe.objects.get(pk=kwargs['pk'])
        if recipe.profile != request.user.profile:
            raise PermissionDenied

        form = self.RecipeForm(instance=recipe)
        formset = self.RecipeIngredientFormSet(queryset=RecipeIngredient.objects.filter(recipe=recipe))
        return render(request, self.template_name, {
            'recipe':recipe,
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        recipe = Recipe.objects.get(pk=kwargs['pk'])
        if recipe.profile != request.user.profile:
            raise PermissionDenied

        form = self.RecipeForm(request.POST,instance=recipe)
        formset = self.RecipeIngredientFormSet(request.POST,queryset=RecipeIngredient.objects.filter(recipe=recipe))

        if (form.is_valid() and formset.is_valid()):
            form.save()
            recipe_ingredients = formset.save(commit=False)
            for recipe_ingredient in recipe_ingredients:
                recipe_ingredient.recipe = recipe
                recipe_ingredient.save()
            return redirect(self.success_url)

        return render(request, self.template_name, {
            'recipe':recipe,
            'form': form,
            'formset': formset
        })

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        self.RecipeIngredientFormSet.form = staticmethod(curry(RecipeIngredientForm,profile=self.request.user.profile))
        return super(RecipeUpdate, self).dispatch(*args, **kwargs)


class RecipeDelete(DeleteView):
    model = Recipe
    success_url = reverse_lazy('menu:recipe_list')

    def get_object(self):
        recipe = super(RecipeDelete,self).get_object()
        if recipe.profile != self.request.user.profile:
            raise PermissionDenied

        return recipe


    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeDelete, self).dispatch(*args, **kwargs)


class IngredientList(ListView):
    model = Ingredient

    def get_queryset(self):
        return Ingredient.objects.filter(
            Q(profile=self.request.user.profile)|Q(private=False)
        )

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientList, self).dispatch(*args, **kwargs)


class IngredientDetailView(DetailView):
    model = Ingredient
    template_name = 'menu/ingredient_detail.html'

    def get_object(self):
        ingredient = super(IngredientDetailView,self).get_object()
        if ingredient.profile != self.request.user.profile:
            raise PermissionDenied

        return ingredient

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientDetailView, self).dispatch(*args, **kwargs)



class IngredientCreate(CreateView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')
    fields = ['private', 'name', 'category']

    def form_valid(self, form):
        form.instance.profile = self.request.user.profile
        return super(IngredientCreate, self).form_valid(form)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientCreate, self).dispatch(*args, **kwargs)



class IngredientUpdate(UpdateView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')
    fields = ['private', 'name', 'category']

    def get_object(self):
        ingredient = super(IngredientUpdate,self).get_object()
        if ingredient.profile != self.request.user.profile:
            raise PermissionDenied

        return ingredient

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientUpdate, self).dispatch(*args, **kwargs)


class IngredientDelete(DeleteView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')

    def get_object(self):
        ingredient = super(IngredientDelete,self).get_object()
        if ingredient.profile != self.request.user.profile:
            raise PermissionDenied

        return ingredient

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientDelete, self).dispatch(*args, **kwargs)

class CalendarView(View):
    template_name = 'menu/calendar.html'

    def render_to_json_response(self, context, **response_kwargs):
        data = json.dumps(context)
        response_kwargs['content_type'] = 'application/json'
        return HttpResponse(data, **response_kwargs)

    def get(self, request, *args, **kwargs):
        if self.request.is_ajax():
            meals = self.request.user.profile.meal_set.filter(
                date__gte=request.GET['start']
            ).filter(
                date__lt=request.GET['end']
            )

            data = []
            count = 0
            for meal in meals:
                count = count + 1
                event = {
                    'title': meal.get_name_display(),
                    'start': (datetime.combine(meal.date, datetime.min.time()) + timedelta(seconds=count)).strftime('%Y-%m-%dT%H:%M:%S'),
                    'pk': meal.pk,
                    'updateUrl': reverse('menu:meal_update', args=[meal.pk]),
                    'deleteUrl': reverse('menu:meal_delete', args=[meal.pk])
                }
                for mealrecipe in meal.mealrecipe_set.all():
                    event['title'] = event['title'] + "\n" + mealrecipe.recipe.name

                data.append(event)

            return self.render_to_json_response(data)
        else:
            return render(request, self.template_name)

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CalendarView, self).dispatch(*args, **kwargs)


class MealCreate(View):
    template_name = 'menu/meal_form.html'
    success_url = reverse_lazy('menu:calendar')
    MealForm = modelform_factory(Meal, fields=('name', 'date'))
    MealRecipeFormSet = modelformset_factory(MealRecipe, form=MealRecipeForm, fields=('recipe',), extra=1)

    def get(self, request, *args, **kwargs):
        form = self.MealForm()
        formset = self.MealRecipeFormSet(queryset=MealRecipe.objects.none())
        return render(request, self.template_name, {
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        form = self.MealForm(request.POST)
        formset = self.MealRecipeFormSet(request.POST)
        if (form.is_valid() and formset.is_valid()):
            meal = form.save(commit=False)
            meal.profile = self.request.user.profile
            meal.save()
            meal_recipes = formset.save(commit=False)
            for meal_recipe in meal_recipes:
                meal_recipe.meal = meal
                meal_recipe.save()

            return redirect(self.success_url)

        return render(request, self.template_name, {
            'form': form,
            'formset': formset
        })

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        self.MealRecipeFormSet.form = staticmethod(curry(MealRecipeForm,profile=self.request.user.profile))
        return super(MealCreate, self).dispatch(*args, **kwargs)

class MealUpdate(View):
    template_name = 'menu/meal_form.html'
    success_url = reverse_lazy('menu:calendar')
    MealForm = modelform_factory(Meal, fields=('name', 'date'))
    MealRecipeFormSet = modelformset_factory(MealRecipe, form=MealRecipeForm, fields=('recipe',), can_delete=True, extra=1)

    def get(self, request, *args, **kwargs):
        meal = Meal.objects.get(pk=kwargs['pk'])
        if meal.profile != request.user.profile:
            raise PermissionDenied

        form = self.MealForm(instance=meal)
        formset = self.MealRecipeFormSet(queryset=MealRecipe.objects.filter(meal=meal))
        return render(request, self.template_name, {
            'meal':meal,
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        meal = Meal.objects.get(pk=kwargs['pk'])
        if meal.profile != request.user.profile:
            raise PermissionDenied

        form = self.MealForm(request.POST,instance=meal)
        formset = self.MealRecipeFormSet(request.POST,queryset=MealRecipe.objects.filter(meal=meal))

        if (form.is_valid() and formset.is_valid()):
            form.save()
            meal_recipes = formset.save(commit=False)
            for meal_recipe in meal_recipes:
                meal_recipe.meal = meal
                meal_recipe.save()
            return redirect(self.success_url)

        return render(request, self.template_name, {
            'meal':meal,
            'form': form,
            'formset': formset
        })

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        self.MealRecipeFormSet.form = staticmethod(curry(MealRecipeForm,profile=self.request.user.profile))
        return super(MealUpdate, self).dispatch(*args, **kwargs)


class MealDelete(DeleteView):
    model = Meal
    success_url = reverse_lazy('menu:calendar')

    def get_object(self):
        meal = super(MealDelete,self).get_object()
        if meal.profile != self.request.user.profile:
            raise PermissionDenied

        return meal

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(MealDelete, self).dispatch(*args, **kwargs)

class GroceryView(FormView):
    template_name = 'menu/grocery.html'
    form_class = GroceryForm
    success_url = reverse_lazy('menu:grocery')

    def get(self, request, *args, **kwargs):

        form = self.form_class()
        return self.generate_grocery_list(form)

    def form_valid(self, form):
        return self.generate_grocery_list(form)

    def generate_grocery_list(self,form):
        if form.is_valid():
            start = form.cleaned_data['start']
            period = form.cleaned_data['period']
        else:
            start = form.fields['start'].initial
            period = form.fields['period'].initial
        if period == GroceryForm.ONE_WEEK:
            end = start + timedelta(days=7)
        else:
            end= start + timedelta(days=14)

        meals = self.request.user.profile.meal_set.filter(
            date__gte=start
        ).filter(
            date__lte=end
        )
        ingredients = {}
        tspAmounts = {}
        for meal in meals:
            for mealrecipe in meal.mealrecipe_set.all():
                for recipeingredient in mealrecipe.recipe.recipeingredient_set.all():
                    logger.debug("{0} - {1} {2}".format(recipeingredient.ingredient, recipeingredient.amount, recipeingredient.unit))
                    if recipeingredient.ingredient not in ingredients.keys():
                        ingredients[recipeingredient.ingredient] = {}
                    if recipeingredient.unit == RecipeIngredient.NONE:
                        # none is handled separately as there is no conversion
                        if recipeingredient.unit not in ingredients[recipeingredient.ingredient].keys():
                            ingredients[recipeingredient.ingredient][recipeingredient.unit] = 0
                        ingredients[recipeingredient.ingredient][recipeingredient.unit] += recipeingredient.amount
                    elif recipeingredient.unit == RecipeIngredient.POUND:
                        # pounds are handled separately as there is no good conversion
                        if recipeingredient.unit not in ingredients[recipeingredient.ingredient].keys():
                            ingredients[recipeingredient.ingredient][recipeingredient.unit] = 0
                        ingredients[recipeingredient.ingredient][recipeingredient.unit] += recipeingredient.amount
                    else:
                        # convert all measurements except none and pounds to tsps
                        converter = Converter(recipeingredient.amount, recipeingredient.unit)
                        converter.convert_to_teaspoons()

                        if recipeingredient.ingredient not in tspAmounts.keys():
                            tspAmounts[recipeingredient.ingredient] = 0
                        tspAmounts[recipeingredient.ingredient] += converter.amount

        logger.debug("converting to highest units")
        # need to convert unit to highest non-decimal unit and add to main ingredient map
        for ingredient in tspAmounts.keys():

            converter = Converter(tspAmounts[ingredient], RecipeIngredient.TEASPOON)
            logger.debug("before {0} - {1} {2}".format(ingredient, converter.amount, converter.unit))
            converter.convert_to_highest()
            if converter.unit not in ingredients[ingredient].keys():
                ingredients[ingredient][converter.unit] = 0

            logger.debug("after {0} - {1} {2}".format(ingredient, converter.amount, converter.unit))
            ingredients[ingredient][converter.unit] += converter.amount

        categories = {}
        for ingredient in ingredients.keys():
            logger.debug("ingredient: {0}".format(ingredient))
            if ingredient.get_category_display() not in categories.keys():
                categories[ingredient.get_category_display()] = []

            categories[ingredient.get_category_display()].append({"ingredient":ingredient, "units" : ingredients[ingredient]})

        logger.debug("categories: {0}".format(categories))
        return render(self.request, self.template_name, {
            'form': form,
            'categories':sorted(categories.items())
        })

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(GroceryView, self).dispatch(*args, **kwargs)




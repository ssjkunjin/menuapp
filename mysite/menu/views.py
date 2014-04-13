from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.core.urlresolvers import reverse_lazy
from django.views.generic import View, ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import login_required
from django.forms.models import modelformset_factory, modelform_factory

from menu.models import Meal, MealRecipe, Profile, Recipe, Ingredient, RecipeIngredient

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

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeList, self).dispatch(*args, **kwargs)

class RecipeDetailView(DetailView):
    model = Recipe
    template_name = 'menu/recipe_detail.html'

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
    RecipeIngredientFormSet = modelformset_factory(RecipeIngredient, fields=('amount','unit','ingredient'), extra=3)

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
        return super(RecipeCreate, self).dispatch(*args, **kwargs)



class RecipeUpdate(View):
    template_name = 'menu/recipe_form.html'
    success_url = reverse_lazy('menu:recipe_list')
    RecipeForm = modelform_factory(Recipe, fields=('name', 'private','rating','directions'))
    RecipeIngredientFormSet = modelformset_factory(RecipeIngredient, fields=('amount','unit','ingredient'), can_delete=True, extra=1)

    def get(self, request, *args, **kwargs):
        recipe = Recipe.objects.get(pk=kwargs['pk'])
        form = self.RecipeForm(instance=recipe)
        formset = self.RecipeIngredientFormSet(queryset=RecipeIngredient.objects.filter(recipe=recipe))
        return render(request, self.template_name, {
            'recipe':recipe,
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        recipe = Recipe.objects.get(pk=kwargs['pk'])
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
        return super(RecipeUpdate, self).dispatch(*args, **kwargs)


class RecipeDelete(DeleteView):
    model = Recipe
    success_url = reverse_lazy('menu:recipe_list')

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeDelete, self).dispatch(*args, **kwargs)


class IngredientList(ListView):
    model = Ingredient

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientList, self).dispatch(*args, **kwargs)


class IngredientDetailView(DetailView):
    model = Ingredient
    template_name = 'menu/ingredient_detail.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientDetailView, self).dispatch(*args, **kwargs)



class IngredientCreate(CreateView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')
    fields = ['name', 'category']

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientCreate, self).dispatch(*args, **kwargs)



class IngredientUpdate(UpdateView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')
    fields = ['name', 'category']

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientUpdate, self).dispatch(*args, **kwargs)


class IngredientDelete(DeleteView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient_list')

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientDelete, self).dispatch(*args, **kwargs)

class CalendarView(ListView):
    model = Meal
    template_name = 'menu/calendar.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CalendarView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(CalendarView, self).get_context_data(**kwargs)
        # Add in a QuerySet of all the recipes
        context['meal_recipes'] = []
        for meal in context['object_list']:
            context['meal_recipes'].append(MealRecipe.objects.filter(meal=meal.pk))
        return context


class MealCreate(View):
    template_name = 'menu/meal_form.html'
    success_url = reverse_lazy('menu:calendar')
    MealForm = modelform_factory(Meal, fields=('name', 'date'))
    MealRecipeFormSet = modelformset_factory(MealRecipe, fields=('recipe',), extra=1)

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
        return super(MealCreate, self).dispatch(*args, **kwargs)

class MealUpdate(View):
    template_name = 'menu/meal_form.html'
    success_url = reverse_lazy('menu:calendar')
    MealForm = modelform_factory(Meal, fields=('name', 'date'))
    MealRecipeFormSet = modelformset_factory(MealRecipe, fields=('recipe',), can_delete=True, extra=1)

    def get(self, request, *args, **kwargs):
        meal = Meal.objects.get(pk=kwargs['pk'])
        form = self.MealForm(instance=meal)
        formset = self.MealRecipeFormSet(queryset=MealRecipe.objects.filter(meal=meal))
        return render(request, self.template_name, {
            'meal':meal,
            'form': form,
            'formset': formset
        })

    def post(self, request, *args, **kwargs):
        meal = Meal.objects.get(pk=kwargs['pk'])
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
        return super(MealUpdate, self).dispatch(*args, **kwargs)


class MealDelete(DeleteView):
    model = Meal
    success_url = reverse_lazy('menu:calendar')

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(MealDelete, self).dispatch(*args, **kwargs)




from django.shortcuts import render
from django.utils.decorators import method_decorator
from django.core.urlresolvers import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import login_required

from menu.models import Profile, Recipe, Ingredient

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

class RecipeDetailView(DetailView):
    model = Recipe
    template_name = 'menu/recipe_detail.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(RecipeDetailView, self).dispatch(*args, **kwargs)


class IngredientList(ListView):
    model = Ingredient

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientList, self).dispatch(*args, **kwargs)


class IngredientCreate(CreateView):
    model = Ingredient
    fields = ['name', 'category']

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientCreate, self).dispatch(*args, **kwargs)



class IngredientUpdate(UpdateView):
    model = Ingredient
    fields = ['name', 'category']

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientUpdate, self).dispatch(*args, **kwargs)


class IngredientDelete(DeleteView):
    model = Ingredient
    success_url = reverse_lazy('menu:ingredient-list')

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(IngredientDelete, self).dispatch(*args, **kwargs)

from django.forms import ChoiceField, DateField, Form, ModelForm, ModelChoiceField
from datetime import date, timedelta
from django.db.models import Q

from menu.models import MealRecipe, Recipe, RecipeIngredient, Ingredient


class MealRecipeForm(ModelForm):
    def __init__(self, *args, **kwargs):
        profile = kwargs.pop('profile')
        super(MealRecipeForm, self).__init__(*args, **kwargs)
        qs = Recipe.objects.filter(
            Q(profile=profile)|Q(private=False)
        ).order_by('name')

        self.fields['recipe'].queryset = qs


    class Meta:
        model = MealRecipe
        fields=['recipe']

class RecipeIngredientForm(ModelForm):
    def __init__(self, *args, **kwargs):
        profile = kwargs.pop('profile')
        super(RecipeIngredientForm, self).__init__(*args, **kwargs)
        qs = Ingredient.objects.filter(
            Q(profile=profile)|Q(private=False)
        ).order_by('name')

        self.fields['ingredient'].queryset = qs


    class Meta:
        model = RecipeIngredient
        fields=['amount','unit','ingredient']

class GroceryForm(Form):
    ONE_WEEK = '1wk'
    TWO_WEEKS = '2wk'
    PERIOD_CHOICES = (
        (ONE_WEEK, '1 week'),
        (TWO_WEEKS, '2 weeks')

    )

    start = DateField(initial=date.today()-timedelta(days=7))
    period = ChoiceField(choices=PERIOD_CHOICES,initial=ONE_WEEK)



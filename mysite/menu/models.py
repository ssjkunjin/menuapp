from django.db import models
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.core.validators import MinValueValidator, MaxValueValidator

class Profile(models.Model):
    user = models.OneToOneField(User)

    def __str__(self):
        return self.user.username


class Meal(models.Model):
    BREAKFAST = 'bft'
    LUNCH = 'lch'
    DINNER = 'dnr'
    SNACK = 'sck'
    MEAL_CHOICES = (
        (BREAKFAST, 'Breakfast'),
        (LUNCH, 'Lunch'),
        (DINNER, 'Dinner'),
        (SNACK, 'Snack')
    )
    name = models.CharField(max_length=3,
                            choices=MEAL_CHOICES)
    date = models.DateField()
    profile = models.ForeignKey(Profile)

    def __str__(self):
        return '%s - %s' % (self.date,self.name)

class Recipe(models.Model):
    name = models.CharField(max_length=100)
    profile = models.ForeignKey(Profile)
    private = models.BooleanField()
    rating = models.IntegerField(validators=[MinValueValidator(0),MaxValueValidator(5)])
    created = models.DateTimeField(auto_now_add=True)
    directions = models.TextField()

    def __str__(self):
        return '%s' % self.name

class MealRecipe(models.Model):
    meal = models.ForeignKey(Meal)
    recipe = models.ForeignKey(Recipe)

    def __str__(self):
        return '%s - %s' % (self.meal, self.recipe)

class Ingredient(models.Model):
    CONDIMENT = 'cnd'
    DAIRY = 'dry'
    FRUIT = 'frt'
    GRAIN = 'grn'
    MEAT = 'met'
    MISCELLANEOUS = 'mis'
    SPICE = 'spc'
    VEGETABLE = 'veg'

    CATEGORY_CHOICES = (
        (CONDIMENT, 'Condiment'),
        (DAIRY, 'Dairy'),
        (FRUIT, 'Fruit'),
        (GRAIN, 'Grain'),
        (MEAT, 'Meat'),
        (MISCELLANEOUS, 'Miscellaneous'),
        (SPICE, 'Spice'),
        (VEGETABLE, 'Vegetable')

    )
    name = models.CharField(max_length=60)
    category = models.CharField(max_length=3,
                                choices=CATEGORY_CHOICES)

    def get_absolute_url(self):
        return reverse('menu:ingredient_detail', kwargs={'pk': self.pk})

    def __str__(self):
        return self.name

class RecipeIngredient(models.Model):
    CUP = 'c'
    GALLON = 'gal'
    OUNCE = 'oz'
    PINT = 'pt'
    POUND = 'lb'
    QUART = 'qt'
    TEASPOON = 'tsp'
    TABLESPOON = 'tbsp'
    NONE = 'none'

    UNIT_CHOICES = (
        (CUP, 'Cup'),
        (GALLON, 'Gallon'),
        (OUNCE, 'Ounce'),
        (PINT, 'Pint'),
        (POUND, 'Pound'),
        (QUART, 'Quart'),
        (TEASPOON, 'Teaspoon'),
        (TABLESPOON, 'Tablespoon'),
        (NONE, '')
    )
    recipe = models.ForeignKey(Recipe)
    amount = models.DecimalField(max_digits=5,
                                 decimal_places=2,
                                 validators=[MinValueValidator(0)])
    unit = models.CharField(max_length=4,
                            choices=UNIT_CHOICES)
    ingredient = models.ForeignKey(Ingredient)

    def __str__(self):
        return '%s - %s' % (self.recipe, self.ingredient)


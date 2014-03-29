from django.db import models
from django.contrib.auth.models import User

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
        (BREAKFAST, 'breakfast'),
        (LUNCH, 'lunch'),
        (DINNER, 'dinner'),
        (SNACK, 'snack')
    )
    name = models.CharField(max_length=3,
                            choices=MEAL_CHOICES)
    date = models.DateField()
    profile = models.ForeignKey(Profile)

    def __str__(self):
        return '%s - %s' % self.date,self.name

class Recipe(models.Model):
    name = models.CharField(max_length=100)
    profile = models.ForeignKey(Profile)
    private = models.BooleanField()
    rating = models.IntegerField()
    created = models.DateTimeField()
    directions = models.TextField()
    meal = models.ForeignKey(Meal)

    def __str__(self):
        return self.name

class Ingredient(models.Model):
    CONDIMENTS = 'cnd'
    DAIRY = 'dry'
    FRUIT = 'frt'
    GRAIN = 'grn'
    MEAT = 'met'
    MISCELLANEOUS = 'mis'
    SPICE = 'spc'
    VEGETABLE = 'veg'

    CATEGORY_CHOICES = (
        (CONDIMENTS, 'condiments'),
        (DAIRY, 'dairy'),
        (FRUIT, 'fruit'),
        (GRAIN, 'grain'),
        (MEAT, 'meat'),
        (MISCELLANEOUS, 'miscellaneous'),
        (SPICE, 'spice'),
        (VEGETABLE, 'vegetable')

    )
    name = models.CharField(max_length=60)
    category = models.CharField(max_length=3,
                                choices=CATEGORY_CHOICES)

    def get_absolute_url(self):
        return reverse('menu:ingredient-detail', kwargs={'pk': self.pk})

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
        (CUP, 'cup'),
        (GALLON, 'gallon'),
        (OUNCE, 'ounce'),
        (PINT, 'pint'),
        (POUND, 'pound'),
        (QUART, 'quart'),
        (TEASPOON, 'teaspoon'),
        (TABLESPOON, 'tablespoon'),
        (NONE, 'none')
    )
    recipe = models.ForeignKey(Recipe)
    amount = models.DecimalField(max_digits=5,
                                 decimal_places=2)
    unit = models.CharField(max_length=4,
                            choices=UNIT_CHOICES)
    ingredient = models.ForeignKey(Ingredient)

    def __str__(self):
        return '%s - %s' % self.recipe, self.ingredient


import logging

from decimal import Decimal
from menu.models import RecipeIngredient

logger = logging.getLogger(__name__)

class Converter:
    def __init__(self, amount, unit):
        self.amount = amount
        self.unit = unit

    def convert_to_teaspoons(self):
        if self.unit == RecipeIngredient.GALLON:
            self.amount *= Decimal(768)
        elif self.unit == RecipeIngredient.QUART:
            self.amount *= Decimal(192)
        elif self.unit == RecipeIngredient.PINT:
            self.amount *= Decimal(96)
        elif self.unit == RecipeIngredient.CUP:
            self.amount *= Decimal(48)
        elif self.unit == RecipeIngredient.OUNCE:
            self.amount *= Decimal(6)
        elif self.unit == RecipeIngredient.TABLESPOON:
            self.amount *= Decimal(3)

    def convert_to_highest(self):
        """ convert upwards until we are at highest unit with non-decimal only value"""

        tempAmount = self.amount
        tempUnit = self.unit

        prevAmount = self.amount
        prevUnit = self.unit

        while tempAmount >= Decimal(1.00):
            prevAmount = tempAmount
            prevUnit = tempUnit
            logger.debug("{0} {1}".format(tempAmount, tempUnit))
            if tempUnit == RecipeIngredient.TEASPOON:
                tempAmount *= Decimal(.333)
                tempUnit = RecipeIngredient.TABLESPOON
            elif tempUnit == RecipeIngredient.TABLESPOON:
                tempAmount *= Decimal(.5)
                tempUnit = RecipeIngredient.OUNCE
            elif tempUnit == RecipeIngredient.OUNCE:
                tempAmount *= Decimal(.125)
                tempUnit = RecipeIngredient.CUP
            elif tempUnit == RecipeIngredient.CUP:
                tempAmount *= Decimal(.5)
                tempUnit = RecipeIngredient.PINT
            elif tempUnit == RecipeIngredient.PINT:
                tempAmount *= Decimal(.5)
                tempUnit = RecipeIngredient.QUART
            elif tempUnit == RecipeIngredient.QUART:
                tempAmount *= Decimal(.25)
                tempUnit = RecipeIngredient.GALLON
            else:
                break

        self.amount = round(prevAmount, 2)
        self.unit = prevUnit

    def __str__(self):
        return "{0} {1}".format(self.amount, self.unit)


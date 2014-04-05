from django.conf.urls import patterns, url

from menu import views

urlpatterns = patterns('',
	url(r'^$', 'django.contrib.auth.views.login', name='login'),
	url(r'^logout$', 'django.contrib.auth.views.logout_then_login', name='logout'),
	url(r'^profile$', views.ProfileView.as_view(), name='profile'),
	url(r'^recipes/$', views.RecipeList.as_view(), name='recipe_list'),
	url(r'^recipe/add/$', views.RecipeCreate.as_view(), name='recipe_add'),
	url(r'^recipe/(?P<pk>\d+)/detail$', views.RecipeDetailView.as_view(), name='recipe_detail'),
	url(r'^recipe/(?P<pk>\d+)/$', views.RecipeUpdate.as_view(), name='recipe_update'),
	url(r'^recipe/(?P<pk>\d+)/delete$', views.RecipeDelete.as_view(), name='recipe_delete'),
	url(r'^ingredients/$', views.IngredientList.as_view(), name='ingredient_list'),
	url(r'^ingredient/add/$', views.IngredientCreate.as_view(), name='ingredient_add'),
	url(r'^ingredient/(?P<pk>\d+)/detail$', views.IngredientDetailView.as_view(), name='ingredient_detail'),
	url(r'^ingredient/(?P<pk>\d+)/$', views.IngredientUpdate.as_view(), name='ingredient_update'),
	url(r'^ingredient/(?P<pk>\d+)/delete$', views.IngredientDelete.as_view(), name='ingredient_delete'),
)
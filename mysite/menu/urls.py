from django.conf.urls import patterns, url

from menu import views

urlpatterns = patterns('',
	url(r'^$', 'django.contrib.auth.views.login', name='login'),
	url(r'^logout$', 'django.contrib.auth.views.logout_then_login', name='logout'),
	url(r'^profile$', views.ProfileView.as_view(), name='profile'),
	url(r'^(?P<pk>\d+)/$', views.RecipeDetailView.as_view(), name='recipe_detail'),
	url(r'^ingredients/$', views.IngredientList.as_view(), name='ingredient_list'),
	url(r'^ingredient/add/$', views.IngredientCreate.as_view(), name='ingredient_add'),
	url(r'^ingredient/(?P<pk>\d+)/$', views.IngredientUpdate.as_view(), name='ingredient_update'),
	url(r'^ingredient/(?P<pk>\d+)/$', views.IngredientDelete.as_view(), name='ingredient_delete'),
)
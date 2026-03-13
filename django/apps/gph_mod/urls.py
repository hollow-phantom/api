from django.urls import path, include
from . import views

app_name = "gph_mod"

urlpatterns = [
    path("proc/", views.ProcListView.as_view(), name="proc"),
]

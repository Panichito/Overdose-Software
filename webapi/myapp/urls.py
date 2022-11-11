from django.urls import path
from .views import *

urlpatterns = [
    path('', Home),
    path('api/newuser', register_newuser),
    path('api/authenticate', authentiate_app),
    path('api/all-caretaker', all_caretaker),
    path('api/all-medicine', all_medicine),
    path('api/post-record', post_record),
    path('api/update-profile/<int:UID>', update_profile),
]

from django.urls import path
from .views import *

urlpatterns = [
    path('', Home, name='home-page'),
    path('about/', About, name='about-page'),
    path('contact/', Contact, name='contact-page'),
    path('api/newuser', register_newuser),
    path('api/authenticate', authentiate_app),
    path('api/all-caretaker', all_caretaker),
    path('api/all-medicine', all_medicine),
    path('api/post-record', post_record),
    path('api/update-profile/<int:UID>', update_profile),
    path('api/ask-caretakerid/<int:UID>', ask_caretakerid),
    path('api/get-mypatient/<int:CID>', get_mypatient),
    path('api/request-caretaker/<int:UID>', request_service),
    path('api/get-records/<int:UID>', get_records),
    path('api/update-record/<int:RID>', update_record),
    path('api/delete-record/<int:RID>', delete_record),
    path('api/user-alerts/<int:UID>', get_all_alerts),
    path('api/record-alerts/<int:RID>', get_specific_alerts),
    path('api/add-alert', add_alert),
    path('api/update-alert/<int:AID>', update_alert),
    path('api/delete-alert/<int:AID>', delete_alert),
]

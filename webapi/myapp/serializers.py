from rest_framework import serializers
from .models import *

class RecordSerializer(serializers.ModelSerializer):
    class Meta:
        model=Record
        # fields=('id', 'title', 'detail')
        fields='__all__'

class CaretakerSerializer(serializers.ModelSerializer):
    class Meta:
        model=Caretaker
        fields='__all__'

class MedicineSerializer(serializers.ModelSerializer):
    class Meta:
        model=Medicine
        fields=('id', 'Medicine_name', 'Medicine_type', 'Medicine_info')

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=('first_name', 'last_name')
        #fields='__all__'

class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model=Member
        fields=('id', 'Member_birthdate', 'Member_gender', 'Member_URLPic')

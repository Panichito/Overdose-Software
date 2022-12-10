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
        fields='__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=('first_name', 'last_name')
        #fields='__all__'

class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model=Member
        fields=('id', 'Member_birthdate', 'Member_gender', 'Member_URLPic')
    
class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model=Patient
        fields=('id', 'caretaker')  # เอา id ออกแล้วขึ้น http 500

class AlertSerializer(serializers.ModelSerializer):
    class Meta:
        model=Alert
        fields='__all__'

class HistorySerializer(serializers.ModelSerializer):
    class Meta:
        model=History
        fields='__all__'

from rest_framework import serializers
from .models import *

class RecordSerializer(serializers.ModelSerializer):
    class Meta:
        model=Record
        # fields=('id', 'title', 'detail')
        fields='__all__'

class MedicineSerializer(serializers.ModelSerializer):
    class Meta:
        model=Medicine
        fields=('id', 'Medicine_name', 'Medicine_type', 'Medicine_info')

from rest_framework import serializers
from .models import Record

class RecordSerializer(serializers.ModelSerializer):
    class Meta:
        model=Record
        # fields=('id', 'title', 'detail')
        fields='__all__'
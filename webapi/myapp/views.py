from django.shortcuts import render
from django.http import JsonResponse
from .models import *

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import RecordSerializer  # import serializers in here

data={"message":"hello Django my old friend"}

def Home(request):
    return JsonResponse(data=data, safe=False, json_dumps_params={'ensure_ascii': False})
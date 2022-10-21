from django.shortcuts import render
from django.http import JsonResponse

data={'message':'hello Django my old friend'}

def Home(request):
    return JsonResponse(data=data)
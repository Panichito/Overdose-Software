from django.db import models
from django.contrib.auth.models import User
import datetime

class Member(models.Model):
    ROLES=[ ('PATIENT', 'PATIENT'), ('CARETAKER', 'CARETAKER'), ('ADMIN', 'ADMIN')]
    GENDERS=[('MALE', 'MALE'), ('FEMALE', 'FEMALE')]

    user=models.OneToOneField(User, on_delete=models.CASCADE)
    Member_usertype=models.CharField(max_length=16, choices=ROLES, default='PATIENT')
    Member_birthdate=models.DateField()
    Member_gender=models.CharField(max_length=8, choices=GENDERS)
    Member_token=models.CharField(max_length=100, default='-')
    Member_verified=models.BooleanField(default=False)

    def __str__(self):
        return "M"+str(self.id)

class Caretaker(models.Model):
    member=models.OneToOneField(Member, on_delete=models.CASCADE, null=True, blank=True)
    Caretaker_since=models.DateField(default=datetime.date.today)
    Caretaker_status=models.BooleanField(default=1)

    def __str__(self):
        return "C"+str(self.id)

class Patient(models.Model):
    member=models.OneToOneField(Member, on_delete=models.CASCADE, null=True, blank=True)
    caretaker=models.OneToOneField(Caretaker, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return "P"+str(self.id)

class Medicine(models.Model):
    TYPES=[('Liquid', 'Liquid'), ('Tablet', 'Tablet'), ('Capsules', 'Capsules')]

    Medicine_name=models.CharField(max_length=100)
    Medicine_type=models.CharField(max_length=50, choices=TYPES)
    Medicine_info=models.TextField(null=True, blank=True)
    def __str__(self):
        return "MED"+str(self.id)

class Record(models.Model):
    patient=models.OneToOneField(Patient, on_delete=models.CASCADE, null=True, blank=True )
    medicine=models.OneToOneField(Medicine, on_delete=models.CASCADE, null=True, blank=True)
    Record_disease=models.CharField(max_length=100)
    Record_amount=models.IntegerField(default=0)
    Record_start=models.DateField(default=datetime.date.today)
    Record_end=models.DateField(null=True, blank=True)
    Record_info=models.TextField(null=True, blank=True)

    def __str__(self):
        return "R"+str(self.id)
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
    Member_URLPic=models.URLField(default='https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg', max_length=250)
    # store image on cloud
    # from cloudinary.models import CloudinaryField
    # Member_Pic=CloudinaryField('hotel', null=True, blank=True, default=None, folder='poonveh-cpe231/hotel')  

    def __str__(self):
        return "M"+str(self.id)+" - "+str(self.user.username)

class Caretaker(models.Model):
    member=models.OneToOneField(Member, on_delete=models.CASCADE)
    Caretaker_since=models.DateField(default=datetime.date.today)
    Caretaker_status=models.BooleanField(default=1)

    def __str__(self):
        return "C"+str(self.id)+" - "+str(self.member.user.username)

class Patient(models.Model):
    member=models.OneToOneField(Member, on_delete=models.CASCADE)
    caretaker=models.ForeignKey(Caretaker, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return "P"+str(self.id)+" - "+str(self.member.user.username)

class Medicine(models.Model):
    TYPES=[('Liquid', 'Liquid'), ('Tablet', 'Tablet'), ('Capsules', 'Capsules')]

    Medicine_name=models.CharField(max_length=100)
    Medicine_type=models.CharField(max_length=50, choices=TYPES)
    Medicine_info=models.TextField(null=True, blank=True)
    Medicine_URLPic=models.URLField(default='https://cdn.pixabay.com/photo/2013/07/18/10/55/dna-163466_960_720.jpg', max_length=250)
    def __str__(self):
        return "M"+str(self.id)+": "+str(self.Medicine_name)

class Record(models.Model):
    patient=models.ForeignKey(Patient, on_delete=models.CASCADE)
    medicine=models.ForeignKey(Medicine, on_delete=models.CASCADE)
    Record_disease=models.CharField(max_length=100)
    Record_amount=models.IntegerField(default=0)
    Record_start=models.DateField(default=datetime.date.today)
    Record_end=models.DateField(null=True, blank=True)
    Record_info=models.TextField(null=True, blank=True)
    Record_isComplete=models.BooleanField(default=False)

    def __str__(self):
        return "R"+str(self.id)+" - "+str(self.patient.member.user.username)+", "+str(self.medicine.Medicine_name)+", "+str(self.Record_disease)

class Alert(models.Model):
    record=models.ForeignKey(Record, on_delete=models.CASCADE)
    Alert_time=models.TimeField(auto_now=False, auto_now_add=False, null=True, blank=True)  # if null means notify daily
    Alert_isTake=models.BooleanField(default=False)

    def __str__(self):
        return "A"+str(self.id)+", "+str(self.Alert_time)

class History(models.Model):
    alert=models.OneToOneField(Alert, on_delete=models.CASCADE)
    History_takeTime=models.DateTimeField(auto_now=False, auto_now_add=False, null=True, blank=True)
    
    def __str__(self):
        return "H"+str(self.id)

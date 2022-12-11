from django.shortcuts import render
from django.http import JsonResponse
from .models import *

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import *  # import serializers in here

from django.contrib.auth.models import User
import uuid
@api_view(['POST'])
def register_newuser(request):
    if request.method=='POST':
        data=request.data
        print('REGISTER: ', data['username'])

        username=data.get('username')
        password=data.get('password')
        email=data.get('email')
        first_name=data.get('first_name')
        last_name=data.get('last_name')
        gender=data.get('gender')
        birthday=data.get('birthday')
        profilepic=data.get('profilepic')
        
        print('CHECK USR: ', username, password)
        if username==None and password==None:
            dt={'status':'username and password cannot be empty'}
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)
        
        check=User.objects.filter(username=username)  # เช็คว่ามียูสเซอร์เนมนี้ไหม
        if len(check)==0:
            newuser=User()
            newuser.username=username
            newuser.set_password(password)  # sha256
            newuser.first_name=first_name
            newuser.last_name=last_name
            newuser.email=email
            newuser.save()

            newmember=Member()
            newmember.user=User.objects.get(username=username)
            newmember.Member_usertype='PATIENT'
            newmember.Member_gender=gender
            newmember.Member_birthdate=birthday
            gentoken=uuid.uuid1().hex
            newmember.Member_token=gentoken
            print(profilepic)
            newmember.Member_URLPic=profilepic
            newmember.save()

            # create patient table
            newpatient=Patient()
            newpatient.member=newmember
            newpatient.save()

            dt={'status':'account-created', 'token':gentoken, 'first_name':first_name, 'last_name':last_name, 'username':username}
            return Response(data=dt, status=status.HTTP_201_CREATED)
        else:
            dt={'status':'user-exist'}
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)

from django.contrib.auth import authenticate, login
@api_view(['POST'])
def authentiate_app(request):
    if request.method=='POST':
        data=request.data
        username=data.get('username')
        password=data.get('password')
        getuser1=User.objects.get(username=username)  # display info back to screen
        
        try:
            user=authenticate(username=username, password=password)
            login(request, user)
            getuser=User.objects.get(username=username)  # display info back to screen
            try:
                cid=getuser.member.patient.caretaker.id
            except:
                cid=0

            dt={'status':'login-succeed', 'token':getuser.member.Member_token, 'first_name':getuser.first_name, 'last_name':getuser.last_name, 
            'username':getuser.username, 'role':getuser.member.Member_usertype, 'profilepic':getuser.member.Member_URLPic,
            'birthdate':getuser.member.Member_birthdate, 'gender':getuser.member.Member_gender, 'cid':cid, 'id':getuser.id}
            print('Succeed', dt)
            return Response(data=dt, status=status.HTTP_200_OK)
        except:
            dt={'status':'login-failed'}
            return Response(data=dt, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def all_caretaker(request):
    allcaretaker=Caretaker.objects.filter(Caretaker_status=True)
    serializer=CaretakerSerializer(allcaretaker, many=True)
    caretaker_list=[]
    for i in allcaretaker:
        dt={}
        dt['id']=i.id
        dt['fullname']=i.member.user.first_name+' '+i.member.user.last_name
        dt['Caretaker_since']=i.Caretaker_since
        dt['image_url']=i.member.Member_URLPic
        caretaker_list.append(dt)

    #print(dt)
    return Response(data=caretaker_list, status=status.HTTP_200_OK)

@api_view(['GET'])
def all_medicine(request):
    allmedicine=Medicine.objects.all()
    serializer=MedicineSerializer(allmedicine, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def post_record(request):
    allpatient=Patient.objects.all()
    allmedicine=Medicine.objects.all()
    # print check
    for i in allpatient:
        print(i)
    for i in allmedicine:
        print(i)

    if request.method=='POST':
        serializer=RecordSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_profile(request, UID):
    usr=User.objects.get(id=UID)
    mem=Member.objects.get(user=usr)
    print(usr.username, mem.Member_usertype, usr.id, mem.id)
    if request.method=='PUT':
        serializer1=UserSerializer(usr, data=request.data)
        if serializer1.is_valid():
            serializer2=MemberSerializer(mem, data=request.data)
            if serializer2.is_valid():
                profile_upd={}
                serializer1.save()
                serializer2.save()
                profile_upd['status']='updated'
                return Response(data=profile_upd, status=status.HTTP_201_CREATED)
            return Response(serializer2.errors, status=status.HTTP_404_NOT_FOUND)
        return Response(serializer1.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def get_mypatient(request, CID):
    mypatient=Patient.objects.filter(caretaker=CID)
    #serializer=PatientSerializer(mypatient, many=True)  # in fact no need
    patient_list=[]
    for i in mypatient:
        patient_dict={}
        patient_dict['pid']=i.id
        patient_dict['name']=i.member.user.first_name+' '+i.member.user.last_name
        patient_dict['email']=i.member.user.email
        patient_dict['profilepic']=i.member.Member_URLPic
        patient_dict['gender']=i.member.Member_gender
        patient_dict['usertype']=i.member.Member_usertype
        patient_dict['birthdate']=i.member.Member_birthdate
        patient_list.append(patient_dict)
    print(patient_list)
    return Response(data=patient_list, status=status.HTTP_200_OK)

@api_view(['GET'])
def ask_caretakerid(request, UID):
    this_member=Member.objects.get(user=UID)
    this_caretaker=Caretaker.objects.get(member=this_member)
    return Response(data=this_caretaker.id, status=status.HTTP_200_OK)


@api_view(['PUT'])
def request_service(request, UID):
    usr=User.objects.get(id=UID)
    mem=Member.objects.get(user=usr)
    ptn=Patient.objects.get(member=mem)
    print(request.data)
    print(ptn.member.user.username)
    if request.method=='PUT':
        serializer=PatientSerializer(ptn, data=request.data)
        if serializer.is_valid():
            caretaker_upd={}
            serializer.save()
            caretaker_upd['status']='updated'
            return Response(data=caretaker_upd, status=status.HTTP_201_CREATED)
        return Response(data=serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def get_medinfo(request, MID):
    this_med=Medicine.objects.get(id=MID)
    serializer=MedicineSerializer(this_med, many=False)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_user_records(request, UID):
    usr=User.objects.get(id=UID)
    mem=Member.objects.get(user=usr)
    ptn=Patient.objects.get(member=mem)
    rec=Record.objects.filter(patient=ptn, Record_isComplete=False)
    record_list=[]
    for r in rec:
        record_dict={}
        record_dict['rid']=r.id
        record_dict['pid']=r.patient.id
        record_dict['mid']=r.medicine.id
        record_dict['patientname']=r.patient.member.user.first_name+' '+r.patient.member.user.last_name
        record_dict['medname']=r.medicine.Medicine_name
        record_dict['disease']=r.Record_disease
        record_dict['amount']=r.Record_amount
        record_dict['start']=r.Record_start
        record_dict['end']=r.Record_end
        record_dict['info']=r.Record_info
        record_list.append(record_dict)
    return Response(data=record_list, status=status.HTTP_200_OK)

@api_view(['PUT'])
def update_record(request, RID):  # for edit & mark as completed
    rec=Record.objects.get(id=RID)
    if request.method=='PUT':
        data={}
        serializer=RecordSerializer(rec, data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status']='record information has been updated'
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_record(request, RID):
    rec=Record.objects.get(id=RID)
    if request.method=='DELETE':
        data={}
        delete=rec.delete()
        if delete:
            data['status']='record has been deleted'
            statuscode=status.HTTP_200_OK
        else:
            data['status']='failed to delete record'
            statuscode=status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

@api_view(['GET'])
def get_all_alerts(request, UID):
    usr=User.objects.get(id=UID)
    mem=Member.objects.get(user=usr)
    ptn=Patient.objects.get(member=mem)
    rec=Record.objects.filter(patient=ptn, Record_isComplete=False)
    alert_list=[]
    for r in rec:
        alt=Alert.objects.filter(record=r).order_by('Alert_time')
        for a in alt:
            alert_dict={}
            alert_dict['id']=a.id
            alert_dict['disease']=a.record.Record_disease
            alert_dict['medname']=a.record.medicine.Medicine_name
            alert_dict['time']=a.Alert_time
            alert_dict['isTake']=a.Alert_isTake
            alert_list.append(alert_dict)
    sorted_list = sorted(alert_list, key=lambda d: d['time'])   # ไม่งั้นมันจะ sort ในแต่ละ record ไม่ใช่ all alerts
    return Response(data=sorted_list, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_specific_alerts(request, RID):
    rec=Record.objects.get(id=RID)
    alert_list=[]
    if rec.Record_isComplete == False:  # if a record is completed, no need to involve with alert data
        alt=Alert.objects.filter(record=rec)
        for a in alt:
            alert_dict={}
            alert_dict['id']=a.id
            alert_dict['disease']=a.record.Record_disease
            alert_dict['medname']=a.record.medicine.Medicine_name
            alert_dict['time']=a.Alert_time
            alert_dict['isTake']=a.Alert_isTake
            alert_list.append(alert_dict)
    return Response(data=alert_list, status=status.HTTP_200_OK)

@api_view(['POST'])
def add_alert(request):
    if request.method=='POST':
        serializer=AlertSerializer(data=request.data)
        print(request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_alert(request, AID):
    alt=Alert.objects.get(id=AID)
    if request.method=='PUT':
        data={}
        serializer=AlertSerializer(alt, data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status']='alert has been updated'
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_alert(request, AID):
    alt=Alert.objects.get(id=AID)
    if request.method=='DELETE':
        data={}
        delete=alt.delete()
        if delete:
            data['status']='alert has been deleted'
            statuscode=status.HTTP_200_OK
        else:
            data['status']='failed to delete alert'
            statuscode=status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

@api_view(['GET'])
def get_user_history(request, UID):
    usr=User.objects.get(id=UID)
    mem=Member.objects.get(user=usr)
    ptn=Patient.objects.get(member=mem)
    rec=Record.objects.filter(patient=ptn, Record_isComplete=False)
    history_list=[]
    for r in rec:
        alt=Alert.objects.filter(record=r)
        for a in alt:
            his=History.objects.filter(alert=a).order_by('-History_takeDate', 'History_takeTime')
            for h in his:
                history_dict={}
                history_dict['id']=h.id
                history_dict['medname']=h.alert.record.medicine.Medicine_name
                history_dict['takeDate']=h.History_takeDate
                history_dict['takeTime']=h.History_takeTime
                history_list.append(history_dict)
    sorted_list = sorted(history_list, key=lambda d: d['takeDate'], reverse=True)
    return Response(data=sorted_list, status=status.HTTP_200_OK)

@api_view(['POST'])
def add_history(request):
    if request.method=='POST':
        serializer=HistorySerializer(data=request.data)
        print(request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_history(request, AID):
    alt=Alert.objects.get(id=AID)
    if request.method=='DELETE':
        data={}
        # query for wanted history
        his=History.objects.filter(alert=alt, History_takeDate=datetime.datetime.now().date())  # use filter in case of clear old data
        delete=his.delete()
        if delete:
            data['status']='history has been cleared'
            statuscode=status.HTTP_200_OK
        else:
            data['status']='failed to clear history'
            statuscode=status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

@api_view(['GET'])
def ask_latest_history(request):
    #latest_his=History.objects.last()
    latest_his=History.objects.latest('History_takeDate')
    serializer=HistorySerializer(latest_his)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['PUT'])
def refresh_alerts(request):
    # You talk when you cease to be at peace with your thoughts.
    if request.method=='PUT':
        all_alert=Alert.objects.all()
        all_alert.update(Alert_isTake=request.data['Alert_isTake'])
        data={}
        data['status']='all alert values are now set to '+str(request.data['Alert_isTake'])
        return Response(data=data, status=status.HTTP_200_OK)


def Home(request):
    #return JsonResponse(data=oldhomedata, safe=False, json_dumps_params={'ensure_ascii': False})
    return render(request, 'overdoseweb/home.html')

def About(request):
    return render(request, 'overdoseweb/about.html')

def Contact(request):
    return render(request, 'overdoseweb/contact.html')

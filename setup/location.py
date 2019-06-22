from locationsharinglib import Service
cookies_file = 'location_sharing.cookies'
google_email = 'shankar.kulumani@gmail.com'
service = Service(cookies_file=cookies_file, authenticating_account=google_email)
# print(service.get_shared_people())
for person in service.get_shared_people():
    print(person)

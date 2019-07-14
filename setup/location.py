from locationsharinglib import Service
cookies_file = '../location_sharing.cookies'
google_email = 'shankar.kulumani@gmail.com'
service = Service(cookies_file=cookies_file, authenticating_account=google_email)
# print(service.get_shared_people())
for person in service.get_shared_people():
    # print(person)
    print("ID: {}".format(person.id))
    print("Address: {}".format(person.address))
    print("Full Name: {}".format(person.full_name))
    print("Last Seen: {}".format(person.datetime))
    print("Nickname: {}".format(person.nickname))
    print("Charging: {}".format(person.charging))
    print("Battery: {}".format(person.battery_level))
    print("Lat: {}, Lon: {}".format(person.latitude, person.longitude))
    print("Picture: {}".format(person.picture_url))

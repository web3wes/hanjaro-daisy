from django.contrib import admin

from .models import User
from .models import Saved_Words

admin.site.register(User)
admin.site.register(Saved_Words)

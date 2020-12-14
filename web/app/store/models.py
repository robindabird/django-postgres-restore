from django.db import models


class Artist(models.Model):
    name = models.CharField(max_length=200, unique=True)
    class Meta:
        db_table = "artist"
    def __str__(self):
        return self.name

class Contact(models.Model):
    email = models.EmailField(max_length=100)
    name = models.CharField(max_length=200)
    class Meta:
        db_table = "contact"
    def __str__(self):
        return self.name

class Album(models.Model):
    reference = models.IntegerField(null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    available = models.BooleanField(default=True)
    title = models.CharField(max_length=200)
    picture = models.URLField()
    artists = models.ManyToManyField(Artist, related_name='albums', blank=True)
    class Meta:
        db_table = "album"
    def __str__(self):
        return self.title

class Booking(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    contacted = models.BooleanField(default=False)
    album = models.OneToOneField(Album, on_delete=models.CASCADE)
    contact = models.ForeignKey(Contact, on_delete=models.CASCADE)
    class Meta:
        db_table = "booking"
    def __str__(self):
        return self.contact.name

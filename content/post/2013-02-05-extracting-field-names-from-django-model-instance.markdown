+++
layout = "post"
title = "Extracting field names from Django model instance"
date = "2013-02-05"

+++
In Django you will normally work with forms and models. A form instance holds
a reference (`form_instance.fields`) to his corresponding fields as a `dict`.
On model instances this `dict` does not exist. This post describes a solution.

<!-- more -->

## Every model instance has a Meta class instance

When you define your models you can create an optional inner class `Meta` which
holds some settings like field excludes or the table name in DB. Every model
instance holds an instance of its Meta class. The examples below make use of a
model called `DomainRequest`.

``` python
>>> inst = DomainRequest()

>>> inst._meta
<Options for DomainRequest>

>>> inst._meta.__class__
django.db.models.options.Options

>>> inst._meta.fields
[<django.db.models.fields.AutoField: id>,
 <django.db.models.fields.DateField: start_date>,
 <django.db.models.fields.DateField: end_date>,
 <django.db.models.fields.related.ForeignKey: owner>,
 <django.db.models.fields.TextField: description>,
 <django.db.models.fields.CharField: status>,
 <json_field.fields.JSONField: internal_state>,
 <django.db.models.fields.CharField: name>,
 <django.db.models.fields.CharField: provider>,
 <django.db.models.fields.CharField: dns_server>,
 <django.db.models.fields.CharField: cancellation>,
 <django.db.models.fields.CharField: place>,
 <django.db.models.fields.BooleanField: as_mail_domain>]

>>> inst._meta.many_to_many
[<django.contrib.contenttypes.generic.GenericRelation: changelog>]
```

`inst._meta.fields` is a list of field instances where each field has a `name`
attribute. This list only contains normal fields but no Many2Many-, ForeignKey
or One2One-Relations which are stored separately in `inst._meta.many_to_many`.

## Extracting field names

The following method extracts all field-names as a list. This is is injected
into [every model
instance](http://blog.pboehm.org/blog/2013/01/26/method-injection-in-python/).

``` python
@property
def fields(self):
    return [ f.name for f in self._meta.fields + self._meta.many_to_many ]

>>> from django.db.models import Model
>>> Model.fields = fields

>>> inst.fields
['id',
 'start_date',
 'end_date',
 'owner',
 'description',
 'status',
 'internal_state',
 'name',
 'provider',
 'dns_server',
 'cancellation',
 'place',
 'as_mail_domain',
 'changelog']
```

The `verbose_name` for every field is also included in `_meta`.  The follwoing
method extracts the field name as keys and verbose_name as values as a dict.

``` python
@property
def fields_verbose(self):
    return dict([ (f.name, f.verbose_name) for f in self._meta.fields + self._meta.many_to_many ])

>>> Model.fields_verbose = fields_verbose
>>> inst.fields_verbose
{'as_mail_domain': u'Freigabe als Maildomain',
 'cancellation': u'K\xfcndigungsfrist',
 'changelog': 'changelog',
 'description': 'Bemerkungen',
 'dns_server': u'DNS-Server',
 'end_date': 'Ablaufdatum',
 'id': 'ID',
 'internal_state': 'internal state',
 'name': 'name',
 'owner': 'Verantwortlicher',
 'place': u'Ort im Domainordner',
 'provider': u'Provider',
 'start_date': 'start date',
 'status': 'status'}
```

+++
layout = "post"
title = "Method Injection in Python"
date = "2013-01-26"

+++

Als ersten Beitrag im Blog, gleich mal ein recht interessantes Thema, nämlich
das dynamische Hinzufügen von Methoden zu bestehenden Klassen. Warum man das
machen möchte und verschiedene Möglichkeiten dies umzusetzen, beschreibt dieser
Beitrag.

<!-- more -->

## Warum?

Die normale Vorgehensweise beim Hinzufügen von Methoden zu Klassen ist es, dies
bei der Klassendefinition zu tun. Das ist auch in 99% aller
Anwendungsfälle die richtige Vorgehensweise, jedoch gibt es einige Szenarien in
denen das nicht möglich/nützlich ist:

* Bei der Nutzung von Frameworks/Libraries könnte man das Bedürfnis haben, existierende Klassen um eigene Methoden zu erweitern bzw. zu überschreiben.
  * Man könnte bestrebt sein, die `__unicode__`-Methode des User-Models in
    Django mit einer eigenen Implementierung zu überschreiben, die den User im
    folgenden Format liefert `Hans Peter (peter)` anstatt `<User: peter>`
  * die Möglichkeit alle seine Django-Models um eine gemeinsame Methode zu
    erweitern, ohne sie zu kopieren oder andere schlimme Dinge zu tun
* Man hat eine Funktionalität (z.B. Logging-Funktionalität) entwickelt und
  sucht nun nach einer Möglichkeit, diese den nutzenden Klassen bereitzustellen
* Vielleicht ist auch nur der Weg zur Klassendefinition zu weit oder die Änderungen
  sollen sich nur auf bestimmte Instanzen auswirken

## Funktionen sind Objekte!

Python ist eine objekt-orientierte Sprache und das, im Gegensatz zu anderen
Sprachen, auch vollständig. Um das zu beweisen, nachfolgend ein Ausflug nach
`python`:

``` python
>>> def test():
...     return "blog.pboehm.org"
...
>>> type(test)
<type 'function'>
>>> isinstance(test, object)
True
>>> test()
'blog.pboehm.org'
```

Wie man hier sieht, ist ein Funktions-Objekt auch nur eine Instanz einer
Subclass von `object`. Genau diese Tatsache bekommt man zu spüren, wenn man
beim Aufrufen von Funktionen/Methoden die entsprechenden Klammern vergisst und
dann das entsprechende Funktionsobjekt, anstatt des Rückgabewertes, geliefert
bekommt.

## Klassen um Methoden erweitern

Bisher wurde immer von Funktionen gesprochen, im Kontext von Klassen werden
diese zu Methoden, indem sie auf Instanzen einer Klasse arbeiten. Die Referenz
auf die eigene Instanz wird in Python explizit mittels `self` angegeben, was
nachfolgend auch zu sehen sein wird.

In dem nachfolgenden Beispiel soll eine Methode erstellt werden, die einem die
Model-Fields eines Django-Model als `list` liefert. Dafür wird eine Methode
`get_field_names` definiert, die aus der Meta-Klasse die entsprechenden Felder
heraussucht. Abschließend wird die Methode zur `Model`-Klasse von Django
hinzugefügt.

``` python
>>> from django.db.models import Model
>>>
>>> def get_field_names(self):
...     return [ f.name for f in self._meta.fields ]
...
>>> Model.get_field_names = get_field_names
```

Die `Model`-Klasse besitzt nun eine neue Methode, welche auch an alle erbenden
Klassen vererbt wird. Auch bereits erstellte Instanzen bekommen diese Methode
hinzugefügt. Das folgende Beispiel verdeutlicht das, indem es eine Instanz des
`User`-Models erstellt, welche von der 'Model'-Klasse erbt und dann die
enthaltenen Felder liefert.

``` python
>>> from django.contrib.auth.models import User

>>> u = User()
>>> u.get_field_names()
['id', 'username', 'first_name', 'last_name', 'email', 'password', 'is_staff', 'is_active', 'is_superuser', 'last_login', 'date_joined']
```

## Ausblick

Mit den hier dargestellten Möglichkeiten sind die Grundlagen gelegt. In einem
zusätzlichen Beitrag wird es dann um Mixins und Decorators gehen, die einem
weitere Möglichkeiten bieten oder die hier dargestellten Möglichkeiten hinter
ein bisschen Syntactic Sugar verbergen.

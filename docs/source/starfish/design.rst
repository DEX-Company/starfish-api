Starfish Design
===============


PlantUML example
----------------

.. uml::

   abstract class AbstractList
   abstract AbstractCollection
   interface List
   interface Collection

   List <|-- AbstractList
   Collection <|-- AbstractCollection

   Collection <|- List
   AbstractCollection <|- AbstractList
   AbstractList <|-- ArrayList

   class ArrayList {
     Object[] elementData
     size()
   }

   enum TimeUnit {
     DAYS
     HOURS
     MINUTES
   }

   annotation SuppressWarnings


Graphviz example
----------------

.. graphviz::

   digraph structs {
     graph [fontsize=8 splines=true overlap=false rankdir = "LR"];
     node [fontname = "Courier New" shape=record];
     struct1 [label="<f0> left|<f1> middle|<f2> right"];
     struct2 [label="<f0> one|<f1> two"];
     struct3 [label="hello\nworld |{ b |{c|<here> d|e}| f}| g | h"];
     struct4 [label="<f0> three|<f1> four"];
     struct1:f0 -> struct4:f0;
     struct1:f1 -> struct2:f0;
     struct1:f2 -> struct3:here;
   }

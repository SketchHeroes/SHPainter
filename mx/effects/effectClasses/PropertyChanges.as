package mx.effects.effectClasses
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class PropertyChanges extends Object
   {
      public function PropertyChanges(param1:Object) {
         this.end={};
         this.start={};
         super();
         this.target=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var end:Object;

      public var start:Object;

      public var target:Object;

      public var stripUnchangedValues:Boolean = true;
   }

}
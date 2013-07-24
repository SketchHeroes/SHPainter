package mx.core
{

   use namespace mx_internal;

   public class UIComponentDescriptor extends ComponentDescriptor
   {
      public function UIComponentDescriptor(param1:Object) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var effects:Array;

      mx_internal var instanceIndices:Array;

      mx_internal var repeaterIndices:Array;

      mx_internal var repeaters:Array;

      public var stylesFactory:Function;

      override public function toString() : String {
         return "UIComponentDescriptor_" + id;
      }
   }

}
package mx.containers.utilityClasses
{
   import mx.core.mx_internal;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class FlexChildInfo extends Object
   {
      public function FlexChildInfo() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var child:IUIComponent;

      public var size:Number = 0;

      public var preferred:Number = 0;

      public var flex:Number = 0;

      public var percent:Number;

      public var min:Number;

      public var max:Number;

      public var width:Number;

      public var height:Number;
   }

}
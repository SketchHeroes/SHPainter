package mx.collections
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ItemWrapper extends Object
   {
      public function ItemWrapper(param1:Object) {
         super();
         this.data=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var data:Object;
   }

}
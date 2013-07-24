package mx.collections.errors
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class CollectionViewError extends Error
   {
      public function CollectionViewError(param1:String) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";
   }

}
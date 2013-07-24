package mx.events
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public final class PropertyChangeEventKind extends Object
   {
      public function PropertyChangeEventKind() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const UPDATE:String = "update";

      public static const DELETE:String = "delete";
   }

}
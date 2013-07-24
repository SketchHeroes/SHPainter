package mx.events
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public final class ListEventReason extends Object
   {
      public function ListEventReason() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const CANCELLED:String = "cancelled";

      public static const OTHER:String = "other";

      public static const NEW_ROW:String = "newRow";
   }

}
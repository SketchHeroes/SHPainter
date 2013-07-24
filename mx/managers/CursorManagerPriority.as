package mx.managers
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public final class CursorManagerPriority extends Object
   {
      public function CursorManagerPriority() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const HIGH:int = 1;

      public static const MEDIUM:int = 2;

      public static const LOW:int = 3;
   }

}
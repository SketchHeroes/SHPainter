package mx.core
{

   use namespace mx_internal;

   public final class ApplicationDomainTarget extends Object
   {
      public function ApplicationDomainTarget() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const DEFAULT:String = "default";

      public static const CURRENT:String = "current";

      public static const PARENT:String = "parent";

      public static const TOP_LEVEL:String = "top-level";
   }

}
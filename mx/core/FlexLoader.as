package mx.core
{
   import flash.display.Loader;
   import mx.utils.NameUtil;

   use namespace mx_internal;

   public class FlexLoader extends Loader
   {
      public function FlexLoader() {
         super();
         try
         {
            name=NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function toString() : String {
         return NameUtil.displayObjectToString(this);
      }
   }

}
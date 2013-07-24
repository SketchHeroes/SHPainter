package mx.core
{
   import flash.display.MovieClip;
   import mx.utils.NameUtil;

   use namespace mx_internal;

   public class FlexMovieClip extends MovieClip
   {
      public function FlexMovieClip() {
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
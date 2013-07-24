package com.reinatech.shpainter.utils
{
   import flash.display.Sprite;
   import flash.printing.PrintJob;
   import flash.printing.PrintJobOptions;
   import flash.printing.PrintJobOrientation;


   public class Printer extends Object
   {
      public function Printer() {
         super();
         return;
      }

      public static function print(param1:Sprite) : void {
         var frame:Sprite = param1;
         var myPrintJob:PrintJob = new PrintJob();
         var options:PrintJobOptions = new PrintJobOptions();
         options.printAsBitmap=true;
         if(myPrintJob.orientation == PrintJobOrientation.LANDSCAPE)
         {
            frame.rotation=90;
         }
         myPrintJob.start();
         try
         {
            myPrintJob.addPage(frame,null,options);
         }
         catch(e:Error)
         {
            return;
         }
         try
         {
            myPrintJob.send();
         }
         catch(e:Error)
         {
            return;
         }
         return;
      }
   }

}
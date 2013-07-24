package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class SoftLightShader extends Shader
   {
      public function SoftLightShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = SoftLightShader_ShaderClass;
   }

}
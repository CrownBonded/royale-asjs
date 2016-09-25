////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.beads
{
    COMPILE::SWF
    {
        import flash.display.Bitmap;
        import flash.display.Loader;
        import flash.display.LoaderInfo;
        import flash.events.IOErrorEvent;
        import flash.net.URLRequest;            
    }
    COMPILE::JS
    {
        import goog.events;
        import org.apache.flex.utils.URLUtils;
    }
	
	import org.apache.flex.core.BeadViewBase;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IBinaryImageModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
    import org.apache.flex.utils.BinaryData;
	
	/**
	 *  The ImageView class creates the visual elements of the org.apache.flex.html.Image component.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class BinaryImageView extends ImageView
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function BinaryImageView()
		{
		}
		
        private var _objectURL:String;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			_model.addEventListener("binaryChanged",handleBinaryChange);

		}

		/**
		 * @private
         * @flexjsignorecoercion HTMLImageELement
         * @flexjsignorecoercion BinaryImageModel
		 */
        private function handleBinaryChange(event:Event):void
        {
            var m:IBinaryImageModel = _model as IBinaryImageModel;
           COMPILE::SWF
            {
                if (m.binary) {
                    setupLoader();
                    loader.loadBytes(m.binary.array);
                }                    
            }
            COMPILE::JS
            {
                if (m.binary) {
                    setupLoader();
                    if(_objectURL)
                        URLUtils.revokeObjectURL(_objectURL);
                    var blob:Blob = new Blob([m.binary.array]);
// I don't think we need to specify the type.
//                    var blob = new Blob([response], {type: "image/png"});
                    _objectURL = URLUtils.createObjectURL(blob);
                    (host.element as HTMLImageElement).src = _objectURL;
                }
            }
        }
	}
}
package com.mikechambers.dof
{
	import flash.display.FocusDirection;

	public class DepthOfField
	{
		private var _focalLength:Number;
		private var _aperture:Number;
		private var _circleOfConfusion:Number;
		private var _focusDistance:Number;
		private var _hyperFocalDistance:Number;
		private var _nearPointDistance:Number;
		private var _farPointDistance:Number;
		private var _totalDepthOfField:Number;
		
		public function DepthOfField(focalLength:Number,
									 focusDistance:Number,
									 aperture:Number, 
									 circleOfConfusion:Number)
		{
			this._focalLength = focalLength;
			this._focusDistance = focusDistance;
			this._aperture = aperture;
			this._circleOfConfusion = circleOfConfusion;
			
			_hyperFocalDistance = DepthOfField.calculateHyperFocalDistance(_focalLength, _aperture, _circleOfConfusion);
			_nearPointDistance = DepthOfField.calculateNearPointDistance(_hyperFocalDistance, _focusDistance, _focalLength);
			_farPointDistance = DepthOfField.calculateFarPointDistance(_hyperFocalDistance, _focusDistance, _focalLength);
			_totalDepthOfField = DepthOfField.calculateTotalDepthOfField(_nearPointDistance, _farPointDistance);
		}
		
		public function get focalLength():Number
		{
			return _focalLength;
		}
		
		public function get aperture():Number
		{
			return _aperture;
		}
		
		public function get circleOfConfusion():Number
		{
			return _circleOfConfusion;
		}
		
		public function get hyperFocalDistance():Number
		{
			return _hyperFocalDistance;
		}
		
		public function get nearPointDistance():Number
		{
			return _nearPointDistance;
		}
		
		public function get farPointDistance():Number
		{
			return _farPointDistance;
		}
		
		public function get totalDepthOfField():Number
		{
			return _totalDepthOfField;
		}
		
		
		public static function calculateHyperFocalDistance(focalLength:Number, 
														   aperture:Number, 
														   circleOfConfusion:Number):Number
		{
			return (focalLength * focalLength) / (aperture * circleOfConfusion);
		}
		
		public static function calculateNearPointDistance(hyperFocalDistance:Number, 
													focusDistance:Number, 
													focalLength:Number):Number
		{
			return (hyperFocalDistance * focusDistance) / (hyperFocalDistance + (focusDistance - focalLength));
		}
		
		public static function calculateFarPointDistance(hyperFocalDistance:Number,
															focusDistance:Number,
															focalLength:Number):Number
		{
			return (hyperFocalDistance * focusDistance) / (hyperFocalDistance - (focusDistance - focalLength));
		}
		
		public static function calculateTotalDepthOfField(nearPoint:Number, farPoint:Number):Number
		{
			return farPoint - nearPoint;
		}
		
	}
}
package tonfall.core
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * @author Andre Michelle
	 */
	public final class WavSample
	{
		private static const NOT_SUPPORTED: Error = new Error( 'Not supported.' );
		
		private var _bytes: ByteArray;
		private var _compression : int;
		private var _numChannels : int;
		private var _rate : int;
		private var _bytesPerSecond : int;
		private var _blockAlign : int;
		private var _bits : int;
		private var _numSignals: uint;
		private var _dataOffset: uint;

		public function WavSample( bytes: ByteArray )
		{
			_bytes = bytes;
			
			init();
		}

		public function get numSignals() : uint
		{
			return _numSignals;
		}
		
		public function extract( target: ByteArray, length: Number, position: Number ) : Number
		{
			if( position >= _numSignals )
				return 0.0;

			if( position + length > _numSignals )
			{
				length = _numSignals - position;
			}

			_bytes.position = _dataOffset + position * _blockAlign;
			
			if( 44100 == _rate )
			{
				if( 16 == _bits )
				{
					if( 1 == _numChannels )
					{
						read16Bit44KhzMono( target, _bytes, length );
					}
					else if( 2 == _numChannels )
					{
						read16Bit44KhzStereo( target, _bytes, length );
					}
					else
					{
						throw NOT_SUPPORTED;
					}
				}
				else
				{
					throw NOT_SUPPORTED;
				}
			}
			else
			{
				throw NOT_SUPPORTED;
			}

			return length;
		}

		private function read16Bit44KhzMono( target: ByteArray, bytes: ByteArray, length: Number ) : void
		{
			var value: Number;
			
			for( var i: int = 0 ; i < length ; ++i )
			{
				value = bytes.readShort() * 3.051850947600e-05;
				
				target.writeFloat( value );
				target.writeFloat( value );
			}
		}
		
		private function read16Bit44KhzStereo( target: ByteArray, bytes: ByteArray, length: Number ) : void
		{
			for( var i: int = 0 ; i < length ; ++i )
			{
				target.writeFloat( bytes.readShort() * 3.051850947600e-05 );
				target.writeFloat( bytes.readShort() * 3.051850947600e-05 );
			}
		}
		
		private function init(): void
		{
			_bytes.position = 0;
			_bytes.endian = Endian.LITTLE_ENDIAN;

			if( _bytes.readUTFBytes( 4 ) != 'RIFF' )
				throw new Error( 'Unknown Format (Not RIFF).' );

			if( _bytes.length != _bytes.readUnsignedInt( ) + 8 )
				throw new Error( 'Length does not match.' );

			if( _bytes.readUTFBytes( 4 ) != 'WAVE' )
				throw new Error( 'Unknown Format (Not WAVE).' );

			var id : String;
			var length : uint;
			var position : uint;

			while( _bytes.bytesAvailable )
			{
				id = _bytes.readUTFBytes( 4 );
				length = _bytes.readUnsignedInt( );
				position = _bytes.position;
				
				switch( id )
				{
					case 'fmt ':
						_compression = _bytes.readUnsignedShort( );
						_numChannels = _bytes.readUnsignedShort( );
						_rate = _bytes.readUnsignedInt( );
						_bytesPerSecond = _bytes.readUnsignedInt( );
						_blockAlign = _bytes.readUnsignedShort( );
						_bits = _bytes.readUnsignedShort( );
						_bytes.position = position + length;
						break;

					case 'data':

						_dataOffset = position;
						_numSignals = length / _blockAlign;
						
						_bytes.position = position + length;
						break;

					default:

						_bytes.position = position + length;
						break;
				}
			}
		}
		
		public function toString(): String
		{
			return '[Sample compression: ' + _compression +
								', numChannels: ' + _numChannels +
								', rate: ' + _rate +
								', bytesPerSecond: ' + _bytesPerSecond +
								', blockAlign: ' + _blockAlign +
								', bits: ' + _bits +
								', numSignals: ' + _numSignals + ']';
		}
	}
}

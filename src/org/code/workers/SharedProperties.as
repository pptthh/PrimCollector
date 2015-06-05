package org.code.workers
{
	public final class SharedProperties
	{
		public function SharedProperties(){}
		
		public static const PRIMS:String = 'prims';
		public static const RX_CH:String = 'rxChannel';
		public static const MRX_CH:String = 'mainWorkerRxChannel';
		public static const WORKER_ID:String = 'workerId';
//		public static const Z_PROP_TEST:String = 'zPropTest';
		
		public static const SHARED_MEMORY:String = 'SharedMemory';
		public static const MAIN_2_BG_CH:String = 'mainToBackgroundChannel';
		public static const BG_2_MAIN_CH:String = 'backgroundToMainChannel';
	}
}
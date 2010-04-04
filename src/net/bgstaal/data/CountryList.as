package net.bgstaal.data
{
	public dynamic class CountryList extends Array
	{
		public function CountryList()
		{
			addItems();
			sortOn("code");
		}
		
		protected function addItems ():void
		{
			
		}
		
	}
}
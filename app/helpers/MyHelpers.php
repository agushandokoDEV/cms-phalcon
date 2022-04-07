<?php

class MyHelpers
{
    
    public function full_date($date)
    {
        $hari=$this->hari($date);
        $tanggal=$this->tanggal($date);
        $jam=$this->jam($date);
        $rs=$hari.', '.$tanggal.', '.$jam;
        return $rs;
    }
    
    public function jam($date)
    {
        $date_hours=date('H:i A', strtotime($date));
        return $date_hours;
    }
    
    public function hari($date=''){
        $hari=date('l',strtotime($date));
        switch($hari){
            
            case 'Sunday':
            $hari='Minggu';
            break;
            
            case 'Monday':
            $hari='Senin';
            break;
            
            case 'Tuesday':
            $hari='Selasa';
            break;
            
            case 'Wednesday':
            $hari='Rabu';
            break;
            
            case 'Thursday':
            $hari='Kamis';
            break;
            
            case 'Friday':
            $hari='Jum\'at';
            break;
            
            case 'Saturday':
            $hari='Sabtu';
            break;
        }
        return $hari;
    }
    
    public function tanggal($data=''){
        if($data == null){
            $date='';
        }else if($data == ''){
            $date='';
        }else if($data == '0000-00-00'){
            $date='';
        }else{
            if(str_word_count($data) == 2){
                $data=explode(' ',$data);
                $data=$data[0];
            }
            $pecah=explode('-', $data);
            $date=array('thn'=>$pecah[0],'bln'=>$pecah[1],'tgl'=>$pecah[2]);
        
            switch($date['bln']){
                case '01':
                $date=$date['tgl'].' Januari '.$date['thn'];
                break;
                
                case '02':
                $date=$date['tgl'].' Februari '.$date['thn'];
                break;
                
                case '03':
                $date=$date['tgl'].' Maret '.$date['thn'];
                break;
                
                case '04':
                $date=$date['tgl'].' April '.$date['thn'];
                break;
                
                case '05':
                $date=$date['tgl'].' Mei '.$date['thn'];
                break;
                
                case '06':
                $date=$date['tgl'].' Juni '.$date['thn'];
                break;
                
                case '07':
                $date=$date['tgl'].' Juli '.$date['thn'];
                break;
                
                case '08':
                $date=$date['tgl'].' Agustus '.$date['thn'];
                break;
                
                case '09':
                $date=$date['tgl'].' September '.$date['thn'];
                break;
                
                case '10':
                $date=$date['tgl'].' Oktober '.$date['thn'];
                break;
                
                case '11':
                $date=$date['tgl'].' November '.$date['thn'];
                break;
                
                case '12':
                $date=$date['tgl'].' Desember '.$date['thn'];
                break;
            }
        }
        return $date;
    }
    
    /**
	 * Create a "Random" String
	 *
	 * @param	string	type of random string.  basic, alpha, alnum, numeric, nozero, unique, md5, encrypt and sha1
	 * @param	int	number of characters
	 * @return	string
	 */
	public function random_string($type = 'alnum', $len = 8)
	{
		switch ($type)
		{
			case 'basic':
				return mt_rand();
			case 'alnum':
			case 'numeric':
			case 'nozero':
			case 'alpha':
				switch ($type)
				{
					case 'alpha':
						$pool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
						break;
					case 'alnum':
						$pool = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
						break;
					case 'numeric':
						$pool = '0123456789';
						break;
					case 'nozero':
						$pool = '123456789';
						break;
				}
				return substr(str_shuffle(str_repeat($pool, ceil($len / strlen($pool)))), 0, $len);
			case 'unique': // todo: remove in 3.1+
			case 'md5':
				return md5(uniqid(mt_rand()));
			case 'encrypt': // todo: remove in 3.1+
			case 'sha1':
				return sha1(uniqid(mt_rand(), TRUE));
		}
	}
    
    public function increment_string($str, $separator = '_', $first = 1){
		preg_match('/(.+)'.preg_quote($separator, '/').'([0-9]+)$/', $str, $match);
		return isset($match[2]) ? $match[1].$separator.($match[2] + 1) : $str.$separator.$first;
	}
    
    public function limit_text($text, $limit) {
      if (str_word_count($text, 0) > $limit) {
          $words = str_word_count($text, 2);
          $pos = array_keys($words);
          $text = substr($text, 0, $pos[$limit]) . '...';
      }
      return $text;
    }
    
    public function char_limit($x, $length)
    {
      if(strlen($x)<=$length)
      {
        echo $x;
      }
      else
      {
        $y=substr($x,0,$length) . '...';
        echo $y;
      }
    }
}
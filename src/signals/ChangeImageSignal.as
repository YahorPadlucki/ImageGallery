package signals
{
import models.vo.ImageVO;

import org.osflash.signals.Signal;

public class ChangeImageSignal extends Signal
{
    public function ChangeImageSignal()
    {
        super (ImageVO)
    }
}
}

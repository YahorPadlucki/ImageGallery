package signals
{
import models.vo.ImageVO;

import org.osflash.signals.Signal;

import views.ui.GalleryView;
import views.ui.renderer.ImageItemRenderer;

public class ImageFadedAwaySignal extends Signal
{
    public function ImageFadedAwaySignal()
    {
        super(ImageVO);
    }
}
}

package controller
{
import org.robotlegs.mvcs.Command;

import servises.IGalleryImageService;

public class LoadImagesCommand extends Command
{
    [Inject]
    public var service:IGalleryImageService;

    override public function execute():void
    {
        service.loadImages();
    }
}
}

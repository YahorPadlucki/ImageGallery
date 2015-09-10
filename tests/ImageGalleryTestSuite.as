package
{
import cases.TestGalleryModel;
import cases.TestGalleryViewMediator;
import cases.TestLocalImagesService;

import models.GalleryModel;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class ImageGalleryTestSuite
{
    public var testLocalImagesService:TestLocalImagesService;
    public var testGalleryModel:TestGalleryModel;
    public var testGalleryViewMediator:TestGalleryViewMediator;

}
}

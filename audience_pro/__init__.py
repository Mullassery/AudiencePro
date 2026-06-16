"""AudiencePro: High-performance audience segmentation library."""

try:
    from ._core import PyAudienceSegmenter as AudienceSegmenter
except ImportError:
    raise ImportError(
        "AudiencePro native extension not found. "
        "Please ensure the package is installed correctly."
    )

__version__ = "0.1.0"
__author__ = "Georgi Mammen Mullassery"
__email__ = "mullassery@gmail.com"
__license__ = "MIT"

__all__ = [
    "AudienceSegmenter",
    "__version__",
    "__author__",
    "__email__",
]

function playVideo() {
    const figures: NodeListOf<HTMLElement> = document.querySelectorAll(".media figure");
    if (!figures) return;

    figures.forEach((figure) => {
        const video: HTMLVideoElement | null = figure.querySelector(".media video");
        const cover: HTMLImageElement | null = figure.querySelector(".media .cover");

        if (!video || !cover) return;

        // Observer to autoplay video when in viewport
        const observer = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting && !video.dataset.played) {
                        playVideo();
                        video.dataset.played = "true"; // Mark video as played once
                    }
                });
            },
            { threshold: 0.5 } // 50% of the video must be visible
        );

        observer.observe(figure);

        function playVideo() {
            cover!.style.opacity = "0"; // Start fade out
            setTimeout(() => {
                cover!.style.visibility = "hidden";
                video!.style.visibility = "visible";
                video!.play();
            }, 300); // Matches transition duration
        }

        // Show cover after video ends
        video.addEventListener("ended", () => {
            video.style.visibility = "hidden";
            cover.style.visibility = "visible";
            setTimeout(() => {
                cover.style.opacity = "1"; // Fade in effect
            }, 50);
        });

        // Manual replay when clicking the cover
        cover.addEventListener("click", () => {
            playVideo();
        });
    });
}

document.addEventListener("DOMContentLoaded", () => {
    playVideo();
});

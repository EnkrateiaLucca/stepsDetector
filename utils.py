from scipy.ndimage.filters import gaussian_filter1d
import numpy as np

def dataPrepRawSignal(data, labels):
    # smoothing the signal
    smoothed_signal = gaussian_filter1d(data["AccZAxis"], sigma=1)

    # segmenting the signal with a window size of 10 seconds
    window_size = 10
    x = np.empty((int(len(data)/window_size - 1), window_size))
    y = np.empty((int(len(data)/window_size - 1),))

    for i in range(0, len(smoothed_signal) - window_size, window_size):
        try:
            x[int(i/window_size)] = smoothed_signal[i:i+window_size]
            y[int(i/window_size)] = labels["Step"][i+window_size]
        except:
            break

    return x, y


def dataPrepProcessedSignal(data, labels):
    x,y = dataPrepRawSignal(data, labels)
    x_processed = np.empty((len(x), 3, 1))
    y_processed = y.copy()
    for i in range(len(x)):
        x_processed[i][0] = x[i].mean()
        x_processed[i][1] = x[i].std()
        x_processed[i][2] = x[i].max()
    
    return x_processed, y_processed


def plotPerformance(history, model_name):    
    plt.figure(figsize=(15,7))
    plt.plot(history.history['loss'], label='loss')
    plt.plot(history.history['accuracy'], label='accuracy')
    plt.title(f"Loss and accuracy of the {model_name} model")
    plt.legend()
    plt.show()


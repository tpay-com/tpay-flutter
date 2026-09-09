import Tpay

extension Headless.Models.PaymentChannel {
    func has(channelId: Int) -> Bool {
        return String(channelId) == self.id
    }
}

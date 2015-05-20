require "rails_helper"

describe Users::Requests::Create do
  let(:user) { create :user }
  let(:success) { double :success, call: true }
  let(:error) { double :error, call: true }

  describe "#perform" do
    subject { Users::Requests::Create.new(user:      user,
                                          latitude:  latitude,
                                          longitude: longitude,
                                          success:   success,
                                          error:     error) }

    before do
      juan = Driver.create_driver("Juan Perez", 5)
      juan.update_location(19.264997, -103.7108419)

      john = Driver.create_driver("John Doe", 22)
      john.update_location(19.265189, -103.713567)

      maria = Driver.create_driver("Maria Guadalupe", 10)
      maria.update_location(19.269585, -103.716614)
      Driver.__elasticsearch__.refresh_index!
    end

    context "with valid attributes" do
      context "and drivers around" do
        let(:latitude) { "19.264987" }
        let(:longitude) { "-103.710863" }

        it "calls the success method" do
          expect(success).to receive(:call)
          subject.perform
        end

        context "trying to create a request twice" do
          before { Driver::Request.create_driver_request(user, latitude, longitude) }

          it "calls the error method" do
            expect(error).to receive(:call).
              with("multiple_driver_requests_not_allowed")

            Users::Requests::Create.new(user:      user,
                                        latitude:  latitude,
                                        longitude: longitude,
                                        success:   success,
                                        error:     error).perform
          end
        end
      end

      context "and no drivers around" do
        let(:latitude) { "19.224500" }
        let(:longitude) { "-103.741848" }

        it "calls the error method" do
          expect(error).to receive(:call).
            with("no_drivers_around")

          subject.perform
        end
      end
    end

    context "with invalid attributes" do
      let(:latitude) { "10.264987" }
      let(:longitude) { "-103.710863" }

      it "calls the error method" do
        expect(error).to receive(:call).
          with("no_drivers_around")

        subject.perform
      end
    end
  end
end

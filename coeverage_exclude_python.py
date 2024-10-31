import re
import shutil

exclude_patterns = [
    r'lib/firebase_options_development.dart',
    r'lib/l10n/l10n.dart',
    r'lib/bootstrap.dart',
    r'lib/shared/helper/get_it_service_locator.dart',
    r'lib/shared/constants/theme_constant.dart',
    r'lib/shared/constants/variables_constant.dart',
    r'lib/shared/constants/.*.dart',
    r'.*.g.dart',
    r'.*.freezed.dart',
    r'lib/shared/navigation/.*',
    r'lib/shared/data_provider/.*',
    r'.*/blocprovider/.*.dart',
    r'lib/shared/widget/card_add_image_widget.dart',
    r'lib/shared/widget/image_widget.dart',
    r'lib/shared/widget/user_photo_widget.dart',
    r'lib/shared/bloc/authentication/authentication_state.dart',
    r'lib/shared/bloc/authentication/listenable.dart',
    r'lib/shared/extension/.*.dart',
    r'lib/shared/repositories/url_repository.dart',
    r'lib/shared/bloc/authentication/authentication_event.dart',
    r'lib/shared/repositories/firebase_module.dart',
    r'lib/shared/repositories/network_module.dart',
    r'lib/shared/models/field_models/field_models_error_get.dart',
    r'lib/shared/widget/dilog_page_widget.dart',
    r'lib/shared/widget/keyboard_scroll_view.dart',
    r'lib/shared/widget/network_image_widget.dart',
    r'lib/app.dart',
    r'lib/components/story_add/widget/field_widget.dart',
    r'lib/shared/models/failure_model/exceptions.dart',
    r'lib/shared/widget/info_version_widget.dart',
    r'lib/shared/widget/viewpager_indicator_widget.dart',
    r'lib/shared/repositories/messaging_module.dart',
    r'lib/shared/repositories/build_repository.dart',
    r'lib/shared/widget/row_sliver_widget.dart',
    r'lib/shared/repositories/failure_repository.dart',
    r'lib/shared/repositories/failure_module.dart',
    r'lib/shared/repositories/app_info_repository.dart',
    r'lib/shared/repositories/data_picker_module.dart',
    r'lib/shared/repositories/mobile_rating_module.dart',
    r'lib/shared/widget/popup_menu_item_widget.dart'
]

def exclude_files(input_file, temp_file, exclude_patterns):
    with open(input_file, 'r') as file:
        lines = file.readlines()
    with open(temp_file, 'w') as file:
        skip_record = False
        for line in lines:
        
            if line.startswith('SF:'):
                path = line[3:].replace("\\",'/').strip()
            
                if any(re.fullmatch(pattern, path) for pattern in exclude_patterns):
                    skip_record = True
        
            if skip_record:
                if line.startswith('end_of_record'):
                    skip_record = False
            else:
                file.write(line)
if __name__ == "__main__":
    input_filename = 'coverage/lcov.info' 
    temp_filename = 'coverage/lcov_filtered.tmp'

    exclude_files(input_filename, temp_filename, exclude_patterns)

    shutil.move(temp_filename, input_filename)
    print(f"Original coverage file has been replaced with the filtered version.")
